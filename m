From: Alessandro Rubini <rubini@gnudd.com>
Subject: amba pl011: where to submit a fix for x86 builds
Date: Fri, 7 Jun 2013 11:38:54 +0200
Message-ID: <20130607093854.GA3429@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux@arm.linux.org.uk, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, Chanho Min <chanho.min@lge.com>, Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
List-Id: linux-serial@vger.kernel.org

Hello.
This is cc'd to $(get_maintainer.pl -f drivers/tty/serial/amba-pl011.c)
and x86 maintainers too.

While working on the pci-to-amba bridge driver (to be resubmitted in
the next days) I have to deal with the problem of pl011 not building,
after phys_to_page was introduced, by Chanho Min (Cc: here) in commit

   cb06ff1 ARM: PL011: Add support for Rx DMA buffer polling.

because x86 has no phys_to_page.

The fix I use is trivially this:

  -       sg_set_page(&sg->sg, phys_to_page(dma_addr),
  +       sg_set_page(&sg->sg, virt_to_page(sg->buf),

(virt_to_page is slower, but other sg_get_page() users do the same
and other solutions are more convoluted).

Shall I submit this to x86 with the pci-to-amba bridge series or to
arm/serial and then note the dependency when posting the bridge series?

thanks
/alessandro
