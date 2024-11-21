native:
	dart run pigeon --input pigeon/interface.dart

publish:
	flutter build web --release && firebase deploy --only=hosting

firebase-token:
	firebase login:ci