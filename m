From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH RFC 0/3] UART slave device support
Date: Wed, 3 Jun 2015 13:49:30 +0200
Message-ID: <56C579D3-E8F8-4B5A-B6E8-993B113F3461@goldelico.com>
References: <55492001.30806@hurleysoftware.com> <DE60E7AA-1BF4-4A68-9638-E09F85FD5C72@goldelico.com> <20150506092738.GB4508@amd> <A2594559-CA92-40C2-A06A-AC2483E85CB1@goldelico.com> <554A03A7.2000504@hurleysoftware.com> <D10E1092-E75F-48F7-86F1-F8987973CEB5@goldelico.com> <20150506123632.GA1764@leverpostej> <BD3D34DD-2FC8-44A2-89FA-35843065F50F@goldelico.com> <20150506141547.GB1764@leverpostej> <EA4AC398-CAEA-40E1-A998-BC528B3788E1@goldelico.com> <20150506171802.GE2974@leverpostej> <B4D487C5-C260-497B-A441-6C381D53616C@goldelico.com> <554B7D33.602@hurleysoftware.com> <9EF54D80-F634-4D59-BFD9-FC79FCFE06DE@goldelico.com> <554B8A14.2080904@hurleysoftware.com> <21C337B3-D612-4931-BA23-6B7518E6E4DD@goldelico.com> <112A49DF-935D-41DF-8DF7-F04CC13B9598@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <112A49DF-935D-41DF-8DF7-F04CC13B9598@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, Mark Rutland <mark.rutland@arm.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, NeilBrown <neil@brown.name>, Pavel Machek <pavel@ucw.cz>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Marek Belisko <marek@goldelico.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, List for communicating with real GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-serial@vger.kernel.org

Hi all,
this patch series is our proposal to add hooks so that the driver for a device connected to an UART can
monitor modem control lines and data activity of the connected chip.

It contains an example for such a device driver which needs such sophisticated power control: wi2wi,w2sg0004

A remote device connected to a RS232 interface is usually power controlled by the DTR line.
The DTR line is managed automatically by the UART driver for open() and close() syscalls
and on demand by tcsetattr().

With embedded devices, the serial peripheral might be directly and always connected to the UART
and there might be no physical DTR line involved. Power control (on/off) has to be done by some
chip specific device driver (which we call "UART slave") through some mechanisms (I2C, GPIOs etc.)
not related to the serial interface. Some devices do not tell their power state except by sending
or not sending data to the UART. In such a case the device driver must be able to monitor data
activity. The role of the device driver is to encapsulate such power control in a single place.

This patch series allows to support such UART slave drivers by providing:
* a mechanism that a slave driver can identify the UART instance it is connected to
* a mechanism that UART slave drivers can register to be notified
* notfications for DTR (and other modem control) state changes
* notifications that the device has sent some data to the UART

A slave device tree entry simply adds a phandle reference to the UART it is connected to, e.g.

	gps {
		compatible = "wi2wi,w2sg0004";
		uart = <&uart1>;
	};

The slave driver calls devm_serial_get_uart_by_phandle() to identify the uart driver.
devm_serial_get_uart_by_phandle() follows the concept of devm_usb_get_phy_by_phandle().

A slave device driver registers itself with serial_register_slave() to receive notifications.
Notification handlers can be registered by serial_register_mctrl_notification() and
serial_register_rx_notification(). If an UART has a NULL slave or a NULL handler registered,
no notifications are sent.

RX notification handlers can define a ktermios setup and modify or decide to throw away the
character that is passed upwards.

This all is a follow-up to the w2sg0004 driver submitted in 2014 that did want to add an optional
GPIO to DTR in omap-serial.c and required the w2sg0004 driver to present itself as a "virtual
GPIO". The idea of a "virtual GPIO"  is not compatible with the concept that DT must
describe hardware (and not virtual hardware). So in this new solution DT only describes that
the w2sg0004 is connected to some UART and how the power state signalling works is left
to the driver implementations.

The rx data notification also removes the concept of having two different pinmux states
and make the w2sg0004 driver intercept rx activities by switching the rx line to a GPIO
interrupt. This was very OMAP3 specific. The new solution is generic and might even be
extensible that the chip driver could filter or consume the rx data before it is passed
to the tty layer.

This patch works on linux-next as intended except one major weakness: we have to call 
uart_change_speed() each time we open the tty. This is the opposite of what we would like
to have: that the slave initializes the uart speed through some termios and the tty level just uses
this setting. We have not yet completely understood how to make this work and are happy
about help in this area.

And of course we would like to see general comments about the whole implementation
approach.


Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
