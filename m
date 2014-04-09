From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: post 3.14 serial regression
Date: Wed, 09 Apr 2014 14:19:34 -0700
Message-ID: <5345B966.5070209@intel.com>
References: <5343416F.8010201@sr71.net>	<20140408122726.227f3da8@alan.etchedpixels.co.uk>	<5344642A.2020703@sr71.net>	<53446C57.5000504@intel.com>	<20140409003648.GB32273@kroah.com>	<CAMuHMdXSa0Ku2f1CR3j5pGOp_joQomc2Cnz=apGRR1K0Eb2qOQ@mail.gmail.com>	<5345A7B3.7020005@sr71.net> <CAMuHMdXtz_W7LCJeOG9--ZmmH4js40-urueCTbS98t8oBgnYCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32207 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933568AbaDIVTg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Apr 2014 17:19:36 -0400
In-Reply-To: <CAMuHMdXtz_W7LCJeOG9--ZmmH4js40-urueCTbS98t8oBgnYCw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Dave Hansen <dave@sr71.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Geert Uytterhoeven <geert+renesas@linux-m68k.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On 04/09/2014 01:59 PM, Geert Uytterhoeven wrote:
> On Wed, Apr 9, 2014 at 10:04 PM, Dave Hansen <dave@sr71.net> wrote:
>> On 04/09/2014 12:41 PM, Geert Uytterhoeven wrote:
>>> Dave: If I understand it correctly, you use console=ttyS2, while the kernel
>>> suddenly changed the order of the serial devices, so your port is no
>>> longer ttyS2, but ttyS4. Hence the serial port is not found, and
>>> uart_remove_one_port() is called on it, taking away your /dev/console for
>>> userspace?
>>
>> Right.
> 
> Does it work with console=ttyS4?

Yes, after raising SERIAL_8250_NR_UARTS to >=6.  It had been set to 4
(the Kconfig default).

