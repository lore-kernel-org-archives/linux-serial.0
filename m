From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] serial: Enable Freescale 16550 workaround on arm
Date: Thu, 08 Oct 2015 09:45:56 +0200
Message-ID: <5847930.GvyTeTDb4p@wuerfel>
References: <20151002001616.GA3885@home.buserror.net>
 <1444257081-30491-1-git-send-email-scottwood@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444257081-30491-1-git-send-email-scottwood@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Scott Wood <scottwood@freescale.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stuart Yoder <stuart.yoder@freescale.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wednesday 07 October 2015 17:31:21 Scott Wood wrote:
> The same serial hardware is present on LS2080A which is arm64, and
> LS1021A which is arm32, so don't limit the workaround to PPC.
> 
> Unlike PPC which uses arch/powerpc/kernel/legacy_serial.c, the ARM
> targets use drivers/tty/serial/of_serial.c, so add the handle_irq
> override check there as well.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
