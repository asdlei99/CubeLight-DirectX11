#pragma once

#include "Common\StepTimer.h"
#include "Common\DeviceResources.h"
#include "Content\Sample3DSceneRenderer.h"
#include "Content\SampleFpsTextRenderer.h"

// Renders Direct2D and 3D content on the screen.
namespace DX11UWA
{
	class DX11UWAMain : public DX::IDeviceNotify
	{
	public:
		DX11UWAMain(const std::shared_ptr<DX::DeviceResources>& deviceResources);
		~DX11UWAMain(void);
		void CreateWindowSizeDependentResources(void);
		void Update(void);
		bool Render(void);

		// IDeviceNotify
		virtual void OnDeviceLost(void);
		virtual void OnDeviceRestored(void);
		
		// Helper functions for the keyboard and mouse input
		void GetKeyboardButtons(const char* buttons);
		void GetMousePos(const Windows::UI::Input::PointerPoint^ pos);

	private:
		// Cached pointer to device resources.
		std::shared_ptr<DX::DeviceResources> m_deviceResources;

		// TODO: Replace with your own content renderers.
		std::unique_ptr<Sample3DSceneRenderer> m_sceneRenderer;
		std::unique_ptr<SampleFpsTextRenderer> m_fpsTextRenderer;

		// Rendering loop timer.
		DX::StepTimer m_timer;

		// Data members for the keyboard and mouse input
		char main_kbuttons[256];
		Windows::UI::Input::PointerPoint^ main_currentpos;
	};
}