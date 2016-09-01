From: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/9] tty: serial: jsm_tty: constify uart_ops structures
Date: Thu, 01 Sep 2016 19:58:15 -0300
Message-ID: <87r3935it4.fsf@linux.vnet.ibm.com>
References: <1472752298-981-1-git-send-email-Julia.Lawall@lip6.fr>
        <1472752298-981-6-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472752298-981-6-git-send-email-Julia.Lawall@lip6.fr> (Julia
        Lawall's message of "Thu, 1 Sep 2016 19:51:34 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Julia Lawall <Julia.Lawall@lip6.fr> writes:

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

Acked-by: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>

-- 
Gabriel Krisman Bertazi
