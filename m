From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH 3/3] serial: crisv10: fix invalid user-pointer check
Date: Tue, 8 Nov 2016 13:51:50 +0100
Message-ID: <20161108125150.GY30704@axis.com>
References: <1478607895-23447-1-git-send-email-johan@kernel.org>
 <1478607895-23447-4-git-send-email-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478607895-23447-4-git-send-email-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jespern@axis.com>, linux-cris-kernel@axis.com
List-Id: linux-serial@vger.kernel.org

On Tue, Nov 08, 2016 at 01:24:55PM +0100, Johan Hovold wrote:
> Drop invalid user-pointer check from TIOCGSERIAL handler.
> 
> A NULL-pointer can be valid in user space and copy_to_user() takes care
> of sanity checking.
> 
> Cc: Mikael Starvik <starvik@axis.com>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> Cc: linux-cris-kernel@axis.com
> Signed-off-by: Johan Hovold <johan@kernel.org>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
