From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty: omap-serial: Keep the wakeup mechanism enabled by
 default
Date: Wed, 18 Apr 2012 20:08:33 +0100
Message-ID: <20120418200833.24ef25ff@pyramind.ukuu.org.uk>
References: <1334579407-16970-1-git-send-email-govindraj.raja@ti.com>
	<87vckyq6ti.fsf@ti.com>
	<CAMrsUdL1S5GiyG0egS=CHg2fdNkyZVF-wuCNGDg547kfTUODng@mail.gmail.com>
	<87mx69nms2.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <87mx69nms2.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Raja, Govindraj" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> The point is that wakeups should be enabled whenever driver is in use,
> and disabled when the driver is not in use.


Which is the tty_port methods for initialisation and shutdown, which are
mutex protected against each other and hang up.

Not sure how the uart layer glue exposes that.

Alan
