From: "Oleksiy Kebkal" <kebkal@gmail.com>
Subject: Re: should RTS init in serial core be tied to CRTSCTS
Date: Wed, 7 Mar 2007 22:30:31 +0100
Message-ID: <57354eff0703071330k2395e9c8n58e12f2111dcb25a@mail.gmail.com>
References: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com>
	 <200703061824.08834.rgetz@blackfin.uclinux.org>
	 <m3irddusp0.fsf@maximus.localdomain>
	 <200703071019.55896.rgetz@blackfin.uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965673AbXCGVaf@vger.kernel.org>
In-Reply-To: <200703071019.55896.rgetz@blackfin.uclinux.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Mike Frysinger <vapier.adi@gmail.com>, rmk@arm.linux.org.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

2007/3/7, Robin Getz <rgetz@blackfin.uclinux.org>:
> Right - so the question is where to manage the default state? I was thinking
> in the resource might be a good idea, but there isn't really a good place for
> it. (You could re-use some bits if flags, but I think that would not be a
> good idea).

/proc/tty/driver/uartN/settings?

-Oleksiy
