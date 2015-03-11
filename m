From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: 8250_dw: fix 'cts-override'
Date: Wed, 11 Mar 2015 14:00:53 +0100
Message-ID: <20150311130053.GA16733@kroah.com>
References: <20150310003731.GA21791@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150310003731.GA21791@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>
Cc: Kevin Cernekee <cernekee@chromium.org>, "JD (Jiandong) Zheng" <jdzheng@broadcom.com>, Ray Jui <rjui@broadcom.com>, Desmond Liu <desmondl@broadcom.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Mar 09, 2015 at 05:37:31PM -0700, Dmitry Torokhov wrote:
> We are dealing with CTS, not DSR here (we dealt with DSR a few lines
> above), so set appropriate bits.
> 
> Reported-by: Kevin Cernekee <cernekee@chromium.org>
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Should this go into 4.0-final, or can it wait for 4.1-rc1?
I'm guessing 4.0-final, but want to make sure.

thanks,

greg k-h
