From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Fri, 15 Jan 2016 17:08:00 +0100
Message-ID: <CB69F6F0-B40B-47D1-B175-8401F43288C5@goldelico.com>
References: <20150511013540.5709.93626.stgit@notabene.brown> <CAAObsKD7-02HVUosXVwqcH6HyGEGYJ9jdNepuNhLiiL+ujO5iw@mail.gmail.com> <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com> <20160113191542.GA12086@leverpostej> <1CD6CA14-AE4F-444F-A9A2-CF9B9485F2DC@goldelico.com> <20160115110106.GA3262@leverpostej> <69F8E1E5-EF49-4C8E-88E9-973F82F7102E@goldelico.com> <569913A1.80606@cogentembedded.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <569913A1.80606@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>
Cc: Mark Rutland <mark.rutland@arm.com>, List for communicating with real GTA04 owners <gta04-owner@goldelico.com>, tomeu@tomeuvizoso.net, NeilBrown <neil@brown.name>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robherring2@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-serial@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Marek Belisko <marek@goldelico.com>
List-Id: linux-serial@vger.kernel.org

Hi Andrey,
ah that is fine to learn about another project that needs some solution (however it will look like).

Am 15.01.2016 um 16:43 schrieb Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>:

> Hi Nikolaus,
> 
> H. Nikolaus Schaller wrote:
>> And IMHO nobody has described that he/she needs a solution to model the*data*  relationship
>> for devices connected behind a tty port.
> 
> I am not sure if my case fits *data* relationship or not in this case. Some time ago I asked about state of your patches.
> In my case I have supervising microcontroller unit (MCU) that is connected to one of UARTs on SoC.
> 
> This MCU implements several functions that will be implemented as MFD driver:
> - watchdog and system reset
> - NVMEM EEPROM
> - HWMON sensors
> - Input/power button
> - and similar low level functions
> 
> So in my case DTS binding looks like:
> 
> &uart3 {
> 	mcu {
> 		line-speed = <baud rate>;
> 		watchdog {
> 			timeout = <ms>;
> 			...other params...
> 		};
> 		eeprom {
> 			#address-cells
> 			#size-cells
> 			cell1 : cell@1 {
> 				reg = <1 2>;
> 			};
> 			cell2 : cell@2 {
> 				reg = <2 1>;
> 			};
> 		};
> 		hwmon {
> 			sensors-list = "voltage", "current", etc...;
> 		}
> 	}
> }

With my proposal it would just become

/ {
	themcu: mcu {
		uart = <&uart3>;
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
};

Which is almost the same. Except that it allows to move your mcu node whereever you like and easily allows to change the interface to connect to a different device by

&themcu {
	uart = <&uart1>;
};

With the subnode style you would need some tricks to get the driver instance for uart3 disabled, although it is possible (everything is possible - just easier or more difficult).

> 
> This MCU receives commands and notifies MFD driver about events via UART protocol.
> It looks like not really a slave though, more like a partnership from data flow point of view.

Yes!. That is why I started to question the term "slave".

And yes, this is the second use case I am aware of: a device that just *uses" the UART to do its works and there is no /dev/tty involved.

> 
> There is no user space code involved in this case as whole interactions are between drivers (just a kick to open /dev/ttyXXX using sys_open, as there is no way to start probe on uart_slave bus and assign line discipline).

Exactly this is what we want to provide as API for the drivers by our patches to serial-core.c. 

We want to allow such a "partner" device to take a line-speed property e.g. from its DT node (or a 9600 constant as for our GPS chip) and ask the UART driver to set the required clocks. Or to get the driver notified that someone has opened the /dev/tty* etc. So make it possible to use some UART from another driver.

In the long run it should be possible to use the UART even if there is no /dev/tty client or interface in user-space but that is something not perfectly working (there is some initialization race in the tty/serial subsystem we have not yet understood).

As you see, I have a driver-specific standpoint (and not coming from user space).

Thanks for sharing this example.

BR,
Nikolaus
