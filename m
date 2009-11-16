From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 2/2] Uart driver for ST Microelectronics
 ConneXt(STA2X11/STA2X10).
Date: Mon, 16 Nov 2009 09:48:03 +0000
Message-ID: <20091116094801.GJ20341@fluff.org.uk>
References: <52CF90264091A14888078A031D780F436EF0F9@ism-mail03.corp.ad.wrs.com>
 <52CF90264091A14888078A031D780F4302F89338@ism-mail03.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52CF90264091A14888078A031D780F4302F89338@ism-mail03.corp.ad.wrs.com>
Sender: linux-pci-owner@vger.kernel.org
To: "Feng, Xiaobing" <Xiaobing.Feng@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-pci@vger.kernel.org, giancarlo.asnaghi@st.com, "Wallin, Anders" <Anders.Wallin@windriver.com>, "D'Agostino, Raffaele" <raffaele.dagostino@windriver.com>, "Li, Li" <Li.Li@windriver.com>, "Tang, ChunQiang" <ChunQiang.Tang@windriver.com>
List-Id: linux-serial@vger.kernel.org

Why not register an AMBA device and use the extant AMBA PL011 driver?

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
