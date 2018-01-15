From: Ed Blake <ed.blake@sondrel.com>
Subject: Re: [PATCH] serial: 8250_dw: Avoid overflow in dw8250_set_termios
Date: Mon, 15 Jan 2018 11:27:54 +0000
Message-ID: <0433bf6f-e8e3-4050-fb54-20b6c764c5c1@sondrel.com>
References: <20180112134507.9030-1-ed.blake@sondrel.com>
 <CAEXMXLR3HYcgm9iknfq3d31TN=Fx-bYy9dHOSouHR5Y9gsN__w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEXMXLR3HYcgm9iknfq3d31TN=Fx-bYy9dHOSouHR5Y9gsN__w@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Nuno_Gon=c3=a7alves?= <nunojpg@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 13/01/18 11:59, Nuno Gonçalves wrote:
> Dear Ed,
>
> Thanks.
>
> Tested-by: Nuno Goncalves <nunojpg@gmail.com>
>
> I just would like to report a aditional issue I find, which I am not
> sure if it is intend behaviour or not. If I set bauds 1152000,
> 1500000, 2000000, 2500000, 3000000, I always get a actually set baud
> of 1500000, because it appears to be the closest baud by my hardware,
> but if I set 3500000, then the port gets disabled.
>
> This is because up to 3000000 the closest integer divider is 1, but
> then it becomes 0, which is invalid.
>
> If we still should return the closest baud, then we must return a
> minimum of 1, and never 0, at uart_get_divisor, or
> serial8250_get_divisor.
>
> Thanks,
> Nuno

Yes, returning a divisor of zero doesn't sound very sensible.  Care to
submit a patch?

-- 
Ed
