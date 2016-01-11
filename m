From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH V2] serial: imx: Fix suspend / resume.
Date: Mon, 11 Jan 2016 18:24:08 -0200
Message-ID: <CAOMZO5BvF2xKQo+apL2E+KZV5Qs-yDG7za_D=dVrfA+Btf1x_w@mail.gmail.com>
References: <20160105155331.6024.7211.stgit@localhost>
 <CAOMZO5BES=YkYjtjPE_=t9Qa11JsgE0TT8-v0CxmtgSuBwWnmw@mail.gmail.com>
 <CAOMZO5ADYomDf5EbGAAPJSjEQFOfKi_r7j+xytSuQA5dQh=V0Q@mail.gmail.com>
 <568F99DD.50809@parkeon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <568F99DD.50809@parkeon.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <kernel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Jan 8, 2016 at 9:13 AM, Martin Fuzzey <mfuzzey@parkeon.com> wrote:

> I have that in my old 3.19 tree too so it's not new.
>
> I didn't submit it because I haven't investigated further to see if it was
> just papering over the real problem..

Thanks, Martin. I moved this to the alsa list, so that we can discuss
this issue there.
