From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] serial: 8250: Do XR17V35X specific wakeup in
 serial8250_do_startup
Date: Mon, 29 Jun 2015 17:26:30 +0200
Message-ID: <20150629152630.GL18569@8bytes.org>
References: <1434726737-2585-1-git-send-email-joro@8bytes.org>
 <20150619170910.GA6002@deathray>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150619170910.GA6002@deathray>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Peter Hurley <peter@hurleysoftware.com>, Joe Schultz <jschultz@xes-inc.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 19, 2015 at 12:09:10PM -0500, Michael Welling wrote:
> 
> Looks good to me. The datasheet indicates that bit 4 of the EFR needs to be set to access
> to IER [7:5], ISR [5:4], FCR[5:4], MCR[7:5], MSR.

Thanks! I updated the patch a little bit and wrote a better changelog
entry, mentioning the above bits. Will send a new version after the
merge window.


	Joerg
