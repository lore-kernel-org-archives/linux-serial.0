From: Alan Cox <alan@linux.intel.com>
Subject: Re: /proc/stat btime accuracy problem
Date: Thu, 2 Jun 2011 11:00:24 +0100
Message-ID: <20110602110024.4d93243b@bob.linux.org.uk>
References: <BANLkTiniq6GVMJPO_-efKrWHQg9V9Dod9g@mail.gmail.com>
	<1306967733.11492.11.camel@work-vm>
	<BANLkTi=yEMDLEo99WZm2Bt4pi_pog5igww@mail.gmail.com>
	<1306972711.11492.23.camel@work-vm>
	<BANLkTimuPrqN1euyOqAGm2m4Ea1PdbrzDQ@mail.gmail.com>
	<1306975745.11492.30.camel@work-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1306975745.11492.30.camel@work-vm>
Sender: linux-kernel-owner@vger.kernel.org
To: john stultz <johnstul@us.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> CC'ing the linux-serial list and Alan for their thoughts: Does the
> serial port is disabling irqs for 30+ seconds during boot seem at all
> sane?

printk is supposed to work from anywhere so it takes the hit. It should
only be printk that is involved however.

Alan
