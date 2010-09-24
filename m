From: Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: [RESEND PATCH] serial: samsung: fix device name
Date: Fri, 24 Sep 2010 09:34:53 +0200
Message-ID: <20100924073453.GA3840@richter>
References: <20100923190212.18863.25678.stgit@darius-desktop>
	<4C9BE577.4050504@fluff.org>
	<AANLkTi=S8v19iT1DC=6Nh9BEgRvKzyzKTKoJmS0Bw1Fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=S8v19iT1DC=6Nh9BEgRvKzyzKTKoJmS0Bw1Fb@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Darius Augulis <augulis.darius@gmail.com>
Cc: kgene.kim@samsung.com, Ben Dooks <ben-linux@fluff.org>, paulius.zaleckas@gmail.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi,

On Fri, Sep 24, 2010 at 09:57:19AM +0300, Darius Augulis wrote:

> It does - now devices are named /dev/s3c2410_serial, and patch changes
> its name to /dev/ttySAC

I wonder if it'd make sense to name them ttyS[0-9]. I've never
understood why the platform standard fixed serial ports on any device
should have a different name.

   Simon
