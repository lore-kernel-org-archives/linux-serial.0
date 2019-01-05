From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH lora-next 3/5] net: lora: sx130x: Add PicoCell serdev
 driver
Date: Sat, 5 Jan 2019 02:49:46 +0100
Message-ID: <9e449443-d063-0175-dfd1-ee42d26d27c4@suse.de>
References: <20190104112131.14451-1-afaerber@suse.de>
 <20190104112131.14451-4-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190104112131.14451-4-afaerber@suse.de>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: linux-lpwan@lists.infradead.org, Ben Whitten <ben.whitten@gmail.com>
Cc: linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, "David S. Miller" <davem@davemloft.net>, Mark Brown <broonie@kernel.org>
List-Id: linux-serial@vger.kernel.org

Am 04.01.19 um 12:21 schrieb Andreas Färber:
> Currently there's still some bugs to be investigated, with communication
> stalling on one device and another reading the radio versions wrong
> (07 / 1f instead of 21, also observed on spi once).

Reproducable 100% on SPI by setting REGCACHE_RBTREE in sx130x.c.

Since this serdev driver was using REGCACHE_NONE still and I don't spot
a register missing as volatile either, I guess it may be a timing issue?

My earlier locking patch is applied, to rule out any non-determinism in
the register access order due to radio vs. concentrator interactions.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
