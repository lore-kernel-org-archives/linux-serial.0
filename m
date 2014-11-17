From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gZ3BpbzogbXhzOiBpbXBsZW1lbnQgZ2V0X2RpcmVjdGlv?=
 =?UTF-8?B?biBjYWxsYmFjaw==?=
Date: Mon, 17 Nov 2014 11:38:54 +0300
Message-ID: <1416213534.761947189@f70.i.mail.ru>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <54695654.3070209@elproma.com.pl>
 <20141117082848.GZ27002@pengutronix.de>
Reply-To: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20141117082848.GZ27002@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: fabio.estevam@freescale.com, =?UTF-8?B?QWxleGFuZHJlIENvdXJib3Q=?= <gnurou@gmail.com>, =?UTF-8?B?UmljaGFyZCBHZW5vdWQ=?= <richard.genoud@gmail.com>, =?UTF-8?B?R3JlZyBLcm9haC1IYXJ0bWFu?= <gregkh@linuxfoundation.org>, =?UTF-8?B?TGludXMgV2FsbGVpag==?= <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elproma.com.pl>, linux-serial@vger.kernel.org, =?UTF-8?B?RmFiaW8gRXN0ZXZhbQ==?= <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hello.

...
> > struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int
> > idx, int *irqs)
> What is idx about? I see it already in the mctrl_gpio API, but there is
> no documentation about how it's used. Is it always 0?

This could be used for drivers with several UARTs, which registered at once.

---
