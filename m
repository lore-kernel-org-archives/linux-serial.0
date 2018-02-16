From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: Re: [PATCH] serial: sh-sci: prevent lockup on full TTY buffers
Date: Fri, 16 Feb 2018 15:27:22 +0100
Message-ID: <CAO3366xcbP5hdLC_fgFfDtNJcqE5vfkVZBjAqk6VN8mAk2wYCA@mail.gmail.com>
References: <1518696147-23790-1-git-send-email-ulrich.hecht+renesas@gmail.com> <20180215131237.4yi42wq4duic7uaq@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20180215131237.4yi42wq4duic7uaq@katana>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 15, 2018 at 2:12 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> This can be prevented by doing a dummy read of the RX data register.
>
> Just so I understand the issue correctly: We are reading the register to
> throw the content away to prevent it being used in the TTY buffers?

Not quite. The problem was that if the buffers are full,
sci_receive_chars() returned immediately without reading anything from
the data register, and that led to a lockup. I am not fully sure why
that is so (I arrived at the fix by examining how the different code
paths look from the serial controller's perspective), but dropping
data here fixes it. At this point buffers are full, so any data
received will have to be discarded anyway.

CU
Uli
