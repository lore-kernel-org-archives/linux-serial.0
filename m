From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC 1/5] platform-drivers-x86: add support for Technologic
 Systems TS-5xxx detection
Date: Wed, 4 May 2011 16:29:54 +0100
Message-ID: <20110504162954.7ecf5b5e@lxorguk.ukuu.org.uk>
References: <1304115712-5299-1-git-send-email-vivien.didelot@savoirfairelinux.com>
	<1304115712-5299-2-git-send-email-vivien.didelot@savoirfairelinux.com>
	<20110430110705.5ca3376b@lxorguk.ukuu.org.uk>
	<1304520382-sup-3361@sfl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1304520382-sup-3361@sfl>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jonas Fonseca <jonas.fonseca@savoirfairelinux.com>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>
List-Id: linux-serial@vger.kernel.org

> It is possible to make a BIOS call (Int 15h / Function B000h) to get
> board information, like the manufacturer ("TS"). It should be a safer
> way to check if we are on a Technologic Systems board. a intcall(0x15,
> &ireg, &oreg) should do the trick to check the platform, before checking
> the SBC ID. What do you think?

And that goes to 'How you do yo know it's safe to call INT 15 0xB000 -
especially as we are in 32bit mode and the BIOS is 16bit so you have to
call it very early meaning its a great way to make something else not
boot.

Does the board not support anything sane like DMI ?

Alan
