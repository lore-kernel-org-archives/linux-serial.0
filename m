From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: Re: [RFC v2 5/6] max9260: add driver for i2c over GMSL passthrough
Date: Wed, 16 Aug 2017 15:23:52 +0200
Message-ID: <CAO3366yOpH3Q0J9YbCh2S_L8yLevag-FaVHNngvD3WoquXzp6w@mail.gmail.com>
References: <1500305076-15570-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1500305076-15570-6-git-send-email-ulrich.hecht+renesas@gmail.com> <20170719150038.GA6172@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20170719150038.GA6172@katana>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-serial@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Peter Rosin <peda@axentia.se>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-i2c@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jul 19, 2017 at 5:00 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> +{
>> +     wait_event_interruptible_timeout(dev->rx_wq,
>> +             dev->rx_state <= RX_FRAME_ERROR,
>> +             HZ/2);
>
> I'd suggest to drop the interruptible. It can be done but it is usually
> not trivial to abort the operation gracefully when a signal comes in.
>
> Also, timeout is superfluous since you don't get the return value?

Be that as it may, I still want a timeout; wouldn't wait_event() block forever?

CU
Uli
