From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH] tty/serial: altera_uart: Convert timers to use
 timer_setup()
Date: Tue, 24 Oct 2017 12:09:19 +0200
Message-ID: <20171024100918.GF1370@distanz.ch>
References: <20171024095956.GA67872@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171024095956.GA67872@beast>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2017-10-24 at 11:59:56 +0200, Kees Cook <keescook@chromium.org> wrote:
> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly.
> 
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-serial@vger.kernel.org
> Cc: nios2-dev@lists.rocketboards.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Tobias Klauser <tklauser@distanz.ch>

Thank you
