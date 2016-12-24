From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] serial: 8250: use initializer instead of memset to clear
 local struct
Date: Sat, 24 Dec 2016 15:47:19 +0900
Message-ID: <CAK7LNARpDFDc9ntf3g03+Vz1gejzDVOpEkA1mRmA6sduNsDKWg@mail.gmail.com>
References: <1482463308-28968-1-git-send-email-yamada.masahiro@socionext.com> <20161223072026.GA23895@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161223072026.GA23895@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-parisc@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Joachim Eastwood <manabian@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Greg,


2016-12-23 16:20 GMT+09:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> On Fri, Dec 23, 2016 at 12:21:48PM +0900, Masahiro Yamada wrote:
>> Leave the way of zero-out to the compiler's decision; the compiler
>> may know a more optimized way than calling memset().
>
> But no, it doesn't, it will leave "blank" areas in the structure with
> bad data in it, which is why we do memset.  See the tree-wide fixups we
> made about a year ago for this very issue.  Are you sure none of these
> structures get copied to userspace?

I have to admit no security consideration was in my mind.

If we talk about the particular case of struct uart_8250_port,
this structure is allocated in the stack temporarily,
then serial8250_register_8250_port() copies its members to another
structure one by one.  So no "blank" area is exposed to the user-space,
I think.

Having said that, we have no good reason to take a risk for this.

So, please feel free to discard this patch.


-- 
Best Regards
Masahiro Yamada
