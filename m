From: Max Staudt <mstaudt@suse.de>
Subject: Re: [PATCH] 8250: option 'force_polling' for buggy IRQs
Date: Wed, 27 Jul 2016 14:14:24 +0200
Message-ID: <2b140616-c210-e754-a854-cd6a5675277d@suse.de>
References: <1469468175-15704-1-git-send-email-mstaudt@suse.de>
 <20160725174712.GA5752@kroah.com>
 <b7ed014e-c6be-01ab-d601-08830d72f8cb@suse.de>
 <20160726150856.GA15676@kroah.com>
 <b383129f-b20b-32e3-41d1-e2c4a68665a2@suse.de>
 <20160727130923.4c20524b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160727130923.4c20524b@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 07/27/2016 02:09 PM, One Thousand Gnomes wrote:
>> I simply thought this patch may be useful for other people as well, that's
>> why I sent it upstream.
> 
> If you set the IRQ to 0 it should poll anyway (0 means 'no IRQ') so I
> don't think the option is needed. At least it seems sufficient to get me
> by when I meet buggy PC BIOSes and the like

That's exactly what the patch does - but if there is already a way to set the
IRQ to 0, I would of course prefer to use that.


It seems I haven't found the trick you're using - could you please tell me how
you set the IRQ to 0?  I can't change it in the BIOS, so I have to do it at
the kernel level at the latest.



Thanks

Max
