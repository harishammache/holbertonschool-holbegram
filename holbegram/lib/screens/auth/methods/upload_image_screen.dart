import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPicture extends StatefulWidget {
	const AddPicture({
		super.key,
		required this.email,
		required this.password,
		required this.username,
	});

	final String email;
	final String password;
	final String username;

	@override
	State<AddPicture> createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
	Uint8List? _image;

	Future<void> selectImageFromGallery() async {
		final pickedImage = await ImagePicker().pickImage(
			source: ImageSource.gallery,
		);

		if (pickedImage == null) {
			return;
		}

		final bytes = await pickedImage.readAsBytes();
		setState(() {
			_image = bytes;
		});
	}

	Future<void> selectImageFromCamera() async {
		final pickedImage = await ImagePicker().pickImage(
			source: ImageSource.camera,
		);

		if (pickedImage == null) {
			return;
		}

		final bytes = await pickedImage.readAsBytes();
		setState(() {
			_image = bytes;
		});
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Container(
				decoration: const BoxDecoration(
					gradient: LinearGradient(
						colors: [Color(0xFF111111), Color(0xFF2B2B2B), Color(0xFF111111)],
						begin: Alignment.topLeft,
						end: Alignment.bottomRight,
					),
				),
				child: SafeArea(
					child: Center(
						child: Padding(
							padding: const EdgeInsets.symmetric(horizontal: 24),
							child: Column(
								mainAxisSize: MainAxisSize.min,
								children: [
									const Text(
										'Add your picture',
										textAlign: TextAlign.center,
										style: TextStyle(
											color: Colors.white,
											fontSize: 28,
											fontWeight: FontWeight.w700,
										),
									),
									const SizedBox(height: 24),
									Container(
										width: 180,
										height: 180,
										decoration: BoxDecoration(
											shape: BoxShape.circle,
											border: Border.all(color: Colors.white24, width: 3),
											boxShadow: const [
												BoxShadow(
													color: Colors.black45,
													blurRadius: 20,
													offset: Offset(0, 10),
												),
											],
										),
										child: ClipOval(
											child: _image != null
													? Image.memory(
															_image!,
															fit: BoxFit.cover,
															width: 180,
															height: 180,
														)
													: Image.network(
															'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png',
															fit: BoxFit.cover,
															width: 180,
															height: 180,
															errorBuilder: (context, error, stackTrace) {
																return Image.asset(
																	'assets/images/logo.png',
																	fit: BoxFit.cover,
																	width: 180,
																	height: 180,
																);
															},
														),
										),
									),
									const SizedBox(height: 32),
									Row(
										mainAxisAlignment: MainAxisAlignment.center,
										children: [
											_ActionIcon(
												icon: Icons.photo_camera,
												label: 'Camera',
												onTap: selectImageFromCamera,
											),
											const SizedBox(width: 24),
											_ActionIcon(
												icon: Icons.photo_library,
												label: 'Gallery',
												onTap: selectImageFromGallery,
											),
										],
									),
									const SizedBox(height: 24),
									Text(
										widget.username,
										style: const TextStyle(
											color: Colors.white70,
											fontSize: 16,
											fontWeight: FontWeight.w600,
										),
									),
									const SizedBox(height: 8),
									Text(
										widget.email,
										style: const TextStyle(
											color: Colors.white54,
											fontSize: 14,
										),
									),
								],
							),
						),
					),
				),
			),
		);
	}
}

class _ActionIcon extends StatelessWidget {
	const _ActionIcon({
		required this.icon,
		required this.label,
		required this.onTap,
	});

	final IconData icon;
	final String label;
	final VoidCallback onTap;

	@override
	Widget build(BuildContext context) {
		return InkWell(
			onTap: onTap,
			borderRadius: BorderRadius.circular(18),
			child: Container(
				width: 120,
				padding: const EdgeInsets.symmetric(vertical: 18),
				decoration: BoxDecoration(
					color: Colors.white.withValues(alpha: 0.08),
					borderRadius: BorderRadius.circular(18),
					border: Border.all(color: Colors.white12),
				),
				child: Column(
					mainAxisSize: MainAxisSize.min,
					children: [
						Icon(icon, color: Colors.white, size: 34),
						const SizedBox(height: 10),
						Text(
							label,
							style: const TextStyle(
								color: Colors.white,
								fontWeight: FontWeight.w600,
							),
						),
					],
				),
			),
		);
	}
}
