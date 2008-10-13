From: Samuel Thibault <samuel.thibault-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>
Subject: Re: Serial Routing In the Kernel
Date: Mon, 13 Oct 2008 14:20:29 +0200
Message-ID: <20081013122029.GE5070@const.bordeaux.inria.fr>
References: <241b8f7b0810130351v572730d8mb43e6df856e37f0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <241b8f7b0810130351v572730d8mb43e6df856e37f0b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Prabhu Chawandi <prabhu.chavandi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Prabhu Chawandi, le Mon 13 Oct 2008 16:21:43 +0530, a =E9crit :
>   I wanted to know where exactly, in which file int the kernel, debug
> messages are routed to the serial console driver...

See calls to register_console in drivers/serial/*

Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
