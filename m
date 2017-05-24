From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v6 net-next 01/17] net: qualcomm: remove unnecessary
 includes
Date: Wed, 24 May 2017 16:42:40 -0400 (EDT)
Message-ID: <20170524.164240.135034942764405181.davem@davemloft.net>
References: <1495545173-22150-2-git-send-email-stefan.wahren@i2se.com>
        <20170524.154111.404338711401048909.davem@davemloft.net>
        <1746915556.279475.1495656327010@email.1und1.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1746915556.279475.1495656327010@email.1und1.de>
Sender: netdev-owner@vger.kernel.org
To: stefan.wahren@i2se.com
Cc: linux-serial@vger.kernel.org, jslaby@suse.com, gregkh@linuxfoundation.org, netdev@vger.kernel.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, kubakici@wp.pl, mark.rutland@arm.com, LinoSanfilippo@gmx.de, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>
Date: Wed, 24 May 2017 22:05:26 +0200 (CEST)

> AFAIK these ones above aren't necessary (no init, no kernel module,
> no kernel parameter, no kernel version) for this C file. So i will
> double check it.

You need the endianness translators like cpu_to_be32() or whatever,
so you need to figure out where you are getting that once these
explicit headers are removed.

And see, it's probably hidden inside of the private header's includes.

So we can't tell.
