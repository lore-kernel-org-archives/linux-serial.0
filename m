From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 5/5] serial/8250_fintek: Support for any io address.
Date: Mon, 15 Jun 2015 15:25:58 +0100
Message-ID: <1434378358.25843.11.camel@linux.intel.com>
References: <1434377926-31958-1-git-send-email-ricardo.ribalda@gmail.com>
	 <1434377926-31958-6-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434377926-31958-6-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Huewe <PeterHuewe@gmx.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw
List-Id: linux-serial@vger.kernel.org

On Mon, 2015-06-15 at 16:18 +0200, Ricardo Ribalda Delgado wrote:
> Fintek chip can be configured for io addresses different than the standard.
> 
> Query the chip for the configured addresses and try to match it with the
> pnp address.

Looks ok to me. I am a little concerned about false positives but it
does everything right in terms of resource management so I guess it
should be ok - and if not we are only going to find the corner case that
blows up by shipping it 8)

Please however fix the dynamic on stack arrays you've got. Doing

	blah foo[] = { 1,2,3,4 };

might well be valid gcc but it generates horrible code when in fact your
arrays should be static/const, not dynamically constructed on stack from
a static copy each call.

Reviewed-by: Alan Cox <alan@linux.intel.com>
