From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] serial: stm32: fix a type issue
Date: Wed, 12 Oct 2016 12:11:11 +0300
Message-ID: <20161012091111.GC5687@mwanda>
References: <20161012062103.GS12841@mwanda>
 <20161012085239.GD1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20161012085239.GD1041@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Alexandre TORGUE <alexandre.torgue@st.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, kernel-janitors@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 12, 2016 at 09:52:39AM +0100, Russell King - ARM Linux wrote:
> On Wed, Oct 12, 2016 at 09:21:03AM +0300, Dan Carpenter wrote:
> > We store UNDEF_REG in a u8.  It causes a problem in functions like
> > stm32_tx_dma_complete() where we check "if (ofs->icr == UNDEF_REG)".
> > 
> > Fixes: 3489187204eb ('serial: stm32: adding dma support')
> 
> Correct form is:
> 
> Fixes: 12-digit-hash ("summary line")

When I originally created the Fixes tag format, I used single quotes.
I don't remember why though and I can change with the times.  :)

regards,
dan carpenter
