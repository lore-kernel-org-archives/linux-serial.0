From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC v2 5/6] max9260: add driver for i2c over GMSL passthrough
Date: Wed, 16 Aug 2017 16:32:25 +0300
Message-ID: <4224346.LEY5A6FZfI@avalon>
References: <1500305076-15570-1-git-send-email-ulrich.hecht+renesas@gmail.com> <20170719150038.GA6172@katana> <CAO3366yOpH3Q0J9YbCh2S_L8yLevag-FaVHNngvD3WoquXzp6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <CAO3366yOpH3Q0J9YbCh2S_L8yLevag-FaVHNngvD3WoquXzp6w@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-serial@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, Peter Rosin <peda@axentia.se>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-i2c@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Ulrich,

On Wednesday 16 Aug 2017 15:23:52 Ulrich Hecht wrote:
> On Wed, Jul 19, 2017 at 5:00 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >> +{
> >> +     wait_event_interruptible_timeout(dev->rx_wq,
> >> +             dev->rx_state <= RX_FRAME_ERROR,
> >> +             HZ/2);
> > 
> > I'd suggest to drop the interruptible. It can be done but it is usually
> > not trivial to abort the operation gracefully when a signal comes in.
> > 
> > Also, timeout is superfluous since you don't get the return value?
> 
> Be that as it may, I still want a timeout; wouldn't wait_event() block
> forever?

I think that Wolfram's point is that you should report the timeout error up to 
the upper layers.

-- 
Regards,

Laurent Pinchart
