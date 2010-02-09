From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC][PATCH v2] serial: spi: add spi-uart driver for Maxim 3110
Date: Mon, 8 Feb 2010 17:26:35 -0700
Message-ID: <fa686aa41002081626i24caff52n15f140d0fffadedd@mail.gmail.com>
References: <20091229222006.1ddb28a4@feng-desktop> <20100208165946.0e4dde83@feng-i7>
	<20100208162010.b1f69728.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iw0-f182.google.com ([209.85.223.182]:56120 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab0BIA05 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Feb 2010 19:26:57 -0500
Received: by iwn12 with SMTP id 12so7928316iwn.26
        for <linux-serial@vger.kernel.org>; Mon, 08 Feb 2010 16:26:55 -0800 (PST)
In-Reply-To: <20100208162010.b1f69728.akpm@linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Feng Tang <feng.tang@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, David Brownell <dbrownell@users.sourceforge.net>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>

On Mon, Feb 8, 2010 at 5:20 PM, Andrew Morton <akpm@linux-foundation.or=
g> wrote:
> On Mon, 8 Feb 2010 16:59:46 +0800
> Feng Tang <feng.tang@intel.com> wrote:
>
>> Hi All,
>>
>> Here is a driver for Maxim 3110 SPI-UART device, please help to revi=
ew.
>>
>> It has been validated with Designware SPI controller (drivers/spi: d=
w_spi.c &
>> dw_spi_pci.c). It supports polling and IRQ mode, supports batch read=
, and
>> provides a console.
>>
>> change since v1:
>> =A0 =A0 =A0 * Address comments from Alan Cox
>> =A0 =A0 =A0 * Use a "use_irq" module parameter to runtime check whet=
her
>> =A0 =A0 =A0 =A0 to use IRQ mode
>> =A0 =A0 =A0 * Add the suspend/resume implementation
>>
>> Thanks!
>> Feng
>>
>> >From 6d14c5d68cdae8d48b6d8a00b6653022f2b100d0 Mon Sep 17 00:00:00 2=
001
>> From: Feng Tang <feng.tang@intel.com>
>> Date: Mon, 8 Feb 2010 16:02:59 +0800
>> Subject: [PATCH] serial: spi: add spi-uart driver for Maxim 3110
>>
>> This is the driver for Max3110 SPI-UART device, which connect
>> to host with SPI interface. It supports baud rates from 300 to
>> 230400, and supports both polling and IRQ mode, as well as
>> providing a console for system use
>>
>> Its datasheet could be found here:
>> http://datasheets.maxim-ic.com/en/ds/MAX3110E-MAX3111E.pdf
>>
>
> I wonder if this is an "spi" subsystem thing or a "serial" subsystem
> thing. =A0It looks more like a serial driver to me.

I'm assuming serial; and hence I haven't picked it up into my tree.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
