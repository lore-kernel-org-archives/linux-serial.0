From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 1/8] serial:st-asc: Add ST ASC driver.
Date: Wed, 8 May 2013 18:31:48 +0200
Message-ID: <201305081831.48566.arnd@arndb.de>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com> <B5A00B86-5332-427E-A82A-5B71EC0979A8@jcrosoft.com> <20130508161527.GA28080@kroah.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130508161527.GA28080@kroah.com>
Sender: linux-doc-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Srinivas KANDAGATLA <srinivas.kandagatla@st.com>, Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will.deacon@arm.com>, jslaby@suse.cz, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Nicolas Pitre <nico@linaro.org>, linux-doc@vger.kernel.org, Stephen Gallimore <stephen.gallimore@st.com>, linux-serial@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Stuart Menefy <stuart.menefy@st.com>, Stephen Warren <swarren@nvidia.com>, Dong Aisheng <dong.aisheng@linaro.org>, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wednesday 08 May 2013, Greg KH wrote:
> > just mention there is not hardware reason to not use the generic ttySx
> > in place of ttyAS as we have only one IP that handle serial on this
> > family of SoC
> > 
> > personally I'll switch to ttySx
> 
> Great, then you can use the same major/minor range as well, so there's
> no more objection from me about this :)

Does that work these days when you have kernel with multiple built-in
uart drivers?

I think it would be good if all uarts were using the same name space
and major/minor numbers, but I think the mess we currently have is
the result of the tty_register_driver() interface reserving the
device number range at driver load time, independent of the presence
of devices.  I would assume that normal distro kernels always ship
with an 8250 driver built-in to allow using that as the console,
and if I read the code correctly, that currently prevents another
uart driver from registering the same major/minor numbers.

	Arnd
