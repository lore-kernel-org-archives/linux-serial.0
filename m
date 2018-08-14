From: Oliver Neukum <oneukum@suse.com>
Subject: Re: serdev: How to attach serdev devices to USB based tty devices?
Date: Tue, 14 Aug 2018 09:23:06 +0200
Message-ID: <1534231386.31827.3.camel@suse.com>
References: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
Sender: netdev-owner@vger.kernel.org
To: Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Rob Herring <robh@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-usb@vger.kernel.org
Cc: Jian-Hong Pan <starnight@g.ncu.edu.tw>, Xue Liu <liuxuenetmail@gmail.com>, Ben Whitten <ben.whitten@lairdtech.com>, Linux-MIPS <linux-mips@linux-mips.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stefan Rehm <rehm@miromico.ch>, "LoRa_Community_Support@semtech.com" <LoRa_Community_Support@semtech.com>, Alexander Graf <agraf@suse.de>, devicetree@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Di, 2018-08-14 at 04:28 +0200, Andreas Färber  wrote:
> My idea then was that if we had some unique criteria like vendor and
> product IDs (or whatever is supported in usb_device_id), we could write
> a usb_driver with suitable USB_DEVICE*() macro. In its probe function we
> could call into the existing tty driver's probe function and afterwards
> try creating and attaching the appropriate serdev device, i.e. a fixed
> USB-to-serdev driver mapping. Problem is that most devices don't seem to
> implement any unique identifier I could make this depend on - either by
> using a standard FT232/FT2232/CH340G chip or by using STMicroelectronics
> virtual com port identifiers in CDC firmware and only differing in the
> textual description [3] the usb_device_id does not seem to match on.

If you really must do this you can benignly fail probe(). Thus you
can compare strings within your probe() method.
This sucks because you need to make sure your drivers are always
loaded in a certain order and you really rely on undocumented
properties, but it can be done.

	Regards
		Oliver
