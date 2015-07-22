From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] Fix data loss in cdc-acm
Date: Wed, 22 Jul 2015 10:40:28 +0200
Message-ID: <1437554428.5445.0.camel@suse.com>
References: <55AC1883.4050605@svenbrauch.de>
	 <20150720172546.GF20628@localhost> <55AD38E5.1090807@svenbrauch.de>
	 <20150721091838.GG20628@localhost> <55AE7714.80306@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55AE7714.80306@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Sven Brauch <mail@svenbrauch.de>, Johan Hovold <johan@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Toby Gray <toby.gray@realvnc.com>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2015-07-21 at 12:45 -0400, Peter Hurley wrote:
> Let me know if you need help instrumenting the tty buffers/throttling
> to help figure out what the actual problem is.
> 
> Regarding the patch itself, I have no opinion on the suitability of
> simply not resubmitting urbs. However, that is exactly how the
> throttle
> mechanism works, and the tty buffer API is specifically designed to
> allow drivers to manage flow via that interface as well (especially
> for high-throughput drivers).

Could you please expand on how this is supposed to work?
For once how does one learn that room is available again?

	Regards
		Oliver
