From: Claudio Scordino <claudio@evidence.eu.com>
Subject: RS485: ioctls defined twice ?
Date: Sun, 15 Aug 2010 16:22:13 +0200
Message-ID: <4C67F815.8020808@evidence.eu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc: Rick Bronson <rick@efn.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi all,

	is there any reason why ioctls TIOCGRS485 and TIOCSRS485 are defined (with the same values) in both include/asm-generic/ioctls.h and arch/arm/include/asm/ioctls.h ?

The same happens also for avr32, powerpc and cris (which, however, defines a different value for TIOCSRS485).

Is it duplicated code ?

Or should these values stay in both asm/ioctls.h and asm-generic/ioctls.h ?

Many thanks,

	Claudio
