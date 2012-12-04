From: Ilya Zykov <ilya@ilyx.ru>
Subject: Re: [PATCH] tty: Correct tty buffer flushing.
Date: Tue, 04 Dec 2012 14:11:27 +0400
Message-ID: <50BDCC4F.10505@ilyx.ru>
References: <50B55A93.4090900@ilyx.ru> <50B6A652.9000107@ilyx.ru> <20121129135418.4237e7f8@pyramind.ukuu.org.uk> <50B76D96.20809@ilyx.ru> <20121204085359.03894026@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121204085359.03894026@bob.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Xiaobing Tu <xiaobing.tu@intel.com>, Jiri Slaby <jslaby@suse.cz>, Alek Du <alek.du@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 04.12.2012 12:53, Alan Cox wrote:
>> Main idea here -  we never flash last (struct tty_buffer) in the
>> active buffer. Only data for ldisc. (tty->buf.head->read =
>> tty->buf.head->commit). At that moment driver can collect(write) data
>> in buffer without conflict.
> 
> This one I agree with (sorry it took a while to get to, I wanted to sit
> and think carefully about it as it is subtle and clever)
> 
> Can you generate a single patch which reverts the unneeded locks and
> adds this instead. Add a Signed-off-by and send it to Greg to get it
> into 3.8/3.9 somewhere.
> 
> Thanks
> 
> Alan
> 

OK.
Thank you.
