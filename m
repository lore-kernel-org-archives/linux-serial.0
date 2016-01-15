From: Andrey Vostrikov <andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Fri, 15 Jan 2016 18:43:29 +0300
Message-ID: <569913A1.80606@cogentembedded.com>
References: <20150511013540.5709.93626.stgit@notabene.brown>
 <CAAObsKD7-02HVUosXVwqcH6HyGEGYJ9jdNepuNhLiiL+ujO5iw@mail.gmail.com>
 <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com>
 <20160113191542.GA12086@leverpostej>
 <1CD6CA14-AE4F-444F-A9A2-CF9B9485F2DC@goldelico.com>
 <20160115110106.GA3262@leverpostej>
 <69F8E1E5-EF49-4C8E-88E9-973F82F7102E@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <69F8E1E5-EF49-4C8E-88E9-973F82F7102E-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: List for communicating with real GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Nikolaus,

H. Nikolaus Schaller wrote:
> And IMHO nobody has described that he/she needs a solution to model the*data*  relationship
> for devices connected behind a tty port.

I am not sure if my case fits *data* relationship or not in this case. Some time ago I asked about state of your patches.
In my case I have supervising microcontroller unit (MCU) that is connected to one of UARTs on SoC.

This MCU implements several functions that will be implemented as MFD driver:
  - watchdog and system reset
  - NVMEM EEPROM
  - HWMON sensors
  - Input/power button
  - and similar low level functions

So in my case DTS binding looks like:

&uart3 {
	mcu {
		line-speed = <baud rate>;
		watchdog {
			timeout = <ms>;
			...other params...
		};
		eeprom {
			#address-cells
			#size-cells
			cell1 : cell@1 {
				reg = <1 2>;
			};
			cell2 : cell@2 {
				reg = <2 1>;
			};
		};
		hwmon {
			sensors-list = "voltage", "current", etc...;
		}
	}
}

This MCU receives commands and notifies MFD driver about events via UART protocol.
It looks like not really a slave though, more like a partnership from data flow point of view.

There is no user space code involved in this case as whole interactions are between drivers (just a kick to open /dev/ttyXXX using sys_open, as there is no way to start probe on uart_slave bus and assign line discipline).


Best regards,
Andrey
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
