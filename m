From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 1/2] serial: amba-pl011: use cpu_relax when polling
 registers
Date: Thu, 5 Nov 2015 20:14:23 -0500
Message-ID: <563BFEEF.3020709@hurleysoftware.com>
References: <1446562867-5693-1-git-send-email-timur@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1446562867-5693-1-git-send-email-timur@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>, Greg Kroah-Hartman <greg@kroah.com>
Cc: andre.przywara@arm.com, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, linux-serial@vger.kernel.org, jslaby@suse.com, jun.nie@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 11/03/2015 10:01 AM, Timur Tabi wrote:
> Busy loops that poll on a register should call cpu_relax().  On some
> architectures, it can lower CPU power consumption or yield to a
> hyperthreaded twin processor.  It also serves as a compiler barrier,
> so it can replace barrier() calls.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
