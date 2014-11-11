From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH -next v2 21/26] pty: Don't drop pty master tty lock to
 hangup slave
Date: Tue, 11 Nov 2014 15:49:59 +0000
Message-ID: <20141111154959.65f5109e@alan.etchedpixels.co.uk>
References: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
	<1415207589-15967-1-git-send-email-peter@hurleysoftware.com>
	<1415207589-15967-22-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415207589-15967-22-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed,  5 Nov 2014 12:13:04 -0500
Peter Hurley <peter@hurleysoftware.com> wrote:

> With the revised tty lock order and lockdep annotation, claiming
> the pty slave lock is now safe while still holding the pty master lock.
> 
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>

Reviewed-by: Alan Cox <alan@linux.intel.com>
