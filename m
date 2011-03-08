From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/7] OMAP2+: mux: Enable wakeup for wakeup enable requested
 pads
Date: Tue, 8 Mar 2011 12:21:43 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103081220140.10981@utopia.booyaka.com>
References: <1299064343-28534-1-git-send-email-govindraj.raja@ti.com> <87lj0u8mrf.fsf@ti.com> <87tyfi49cs.fsf@ti.com> <AANLkTiknEQrqUt1-sY6-aDw4R5ZMP2uErSjRNB5Yex_v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <AANLkTiknEQrqUt1-sY6-aDw4R5ZMP2uErSjRNB5Yex_v@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Kevin Hilman <khilman@ti.com>, r.sricharan@ti.com, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-serial@vger.kernel.org


By the way, if your patch relies on OMAP_DEVICE_PAD_IDLE, you should 
probably sync up with Sricharan, who is apparently planning to remove that 
flag:

   http://www.mail-archive.com/linux-omap@vger.kernel.org/msg46296.html


- Paul
