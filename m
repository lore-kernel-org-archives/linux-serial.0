From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH] tty: serial/crisv10.c: remove unnecessary null pointer
 check
Date: Fri, 18 Jan 2013 14:38:22 +0100
Message-ID: <20130118133821.GQ23529@axis.com>
References: <1358375444-13026-1-git-send-email-dinggnu@gmail.com>
 <1358375444-13026-2-git-send-email-dinggnu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1358375444-13026-2-git-send-email-dinggnu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cong Ding <dinggnu@gmail.com>
Cc: Mikael Starvik <starvik@axis.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-cris-kernel <linux-cris-kernel@axis.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 16, 2013 at 11:30:44PM +0100, Cong Ding wrote:
> The pointer tty is dereferened in line 3135, so it is not necessary to check
> null again in line 3140.

I don't know if we actually need to check the parameter tty from being null,
but when checking the rest of the file, most other functions don't check it.

In any case, gcc is quite likely to remove that check due to the
earlier dereference, so removing it is probably acceptable.

> Signed-off-by: Cong Ding <dinggnu@gmail.com>

Thanks, I'll take it in the CRIS tree.

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
