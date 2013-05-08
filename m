From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 1/8] serial:st-asc: Add ST ASC driver.
Date: Wed, 8 May 2013 21:55:22 +0200
Message-ID: <201305082155.23088.arnd@arndb.de>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com> <20130508143908.GJ24282@game.jcrosoft.org> <518A96DA.5060809@st.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:53837 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab3EHTz3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 May 2013 15:55:29 -0400
In-Reply-To: <518A96DA.5060809@st.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: srinivas.kandagatla@st.com
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-doc@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will.deacon@arm.com>, jslaby@suse.cz, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Nicolas Pitre <nico@linaro.org>, Stephen Gallimore <stephen.gallimore@st.com>, linux-serial@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Stuart Menefy <stuart.menefy@st.com>, Stephen Warren <swarren@nvidia.com>, Dong Aisheng <dong.aisheng@linaro.org>, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org

On Wednesday 08 May 2013, Srinivas KANDAGATLA wrote:
> 
> On 08/05/13 15:39, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>> +
> >> > 
> >> > Please remove all forward declarations, by reordering the functions in
> >> > the way they are called.
> >> > 
> > and drop the dummy functions
>
> We can not remove the dummy functions, as the serial-core does not check
> it before using them.

None of them seem performance critical, so it sounds reasonable to change
this in the core so you don't have to provide them. It's up to Greg to decide
whether he'd like that change or not.

	Arnd
