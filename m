From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] sc16is7xx: fix RTS/CTS implementation
Date: Wed, 27 Jul 2016 14:28:44 -0700
Message-ID: <20160727212844.GB7821@kroah.com>
References: <1469653123-21867-1-git-send-email-epsilonrt@gmail.com>
 <1469653123-21867-2-git-send-email-epsilonrt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1469653123-21867-2-git-send-email-epsilonrt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pascal JEAN <epsilonrt@gmail.com>
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jul 27, 2016 at 10:58:42PM +0200, Pascal JEAN wrote:
> Signed-off-by: Pascal JEAN <epsilonrt@gmail.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

I can't take patches with out any changelog text, sorry, please add the
information you had in patch 0/2 to the text in these two patches, plus
any other information that might be needed.

Also, your Signed-off-by: and From: email addresses don't match, please
fix that up somehow.

thanks,

greg k-h
