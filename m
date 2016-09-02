From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 3/9] serial: altera: constify uart_ops structures
Date: Fri, 2 Sep 2016 10:36:56 +0200
Message-ID: <20160902083655.GE8952@distanz.ch>
References: <1472752298-981-1-git-send-email-Julia.Lawall@lip6.fr>
 <1472752298-981-4-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472752298-981-4-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2016-09-01 at 19:51:32 +0200, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> Check for uart_ops structures that are only stored in the ops field of a
> uart_port structure.  This field is declared const, so uart_ops structures
> that have this property can be declared as const also.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct uart_ops i@p = { ... };
> 
> @ok@
> identifier r.i;
> struct uart_port e;
> position p;
> @@
> e.ops = &i@p;
> 
> @bad@
> position p != {r.p,ok.p};
> identifier r.i;
> struct uart_ops e;
> @@
> e@i@p
> 
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct uart_ops i = { ... };
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Tobias Klauser <tklauser@distanz.ch>

Thanks a lot.
