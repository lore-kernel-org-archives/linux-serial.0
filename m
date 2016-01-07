From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH V2] serial: imx: Fix suspend / resume.
Date: Thu, 7 Jan 2016 21:51:28 -0200
Message-ID: <CAOMZO5ADYomDf5EbGAAPJSjEQFOfKi_r7j+xytSuQA5dQh=V0Q@mail.gmail.com>
References: <20160105155331.6024.7211.stgit@localhost>
 <CAOMZO5BES=YkYjtjPE_=t9Qa11JsgE0TT8-v0CxmtgSuBwWnmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOMZO5BES=YkYjtjPE_=t9Qa11JsgE0TT8-v0CxmtgSuBwWnmw@mail.gmail.com>
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

On Thu, Jan 7, 2016 at 9:17 PM, Fabio Estevam <festevam@gmail.com> wrote:

> [   39.487313] [<c05844d0>] (snd_soc_suspend) from [<c03c31f0>]

Ok, in this case it is an ALSA issue, so will start a thread at the
alsa mailing list.
