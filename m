From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: serial drivers polishing
Date: Mon, 29 Apr 2019 18:50:14 +0200
Message-ID: <5a826a97-4098-7e1e-4f07-5a1a372e66b8@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
 <7471c418-4058-db7b-b2ed-af9a67fff201@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7471c418-4058-db7b-b2ed-af9a67fff201@c-s.fr>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe Leroy <christophe.leroy@c-s.fr>, "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org
Cc: lorenzo.pieralisi@arm.com, linux-ia64@vger.kernel.org, linux-serial@vger.kernel.org, andrew@aj.id.au, gregkh@linuxfoundation.org, sudeep.holla@arm.com, liviu.dudau@arm.com, linux-mips@vger.kernel.org, vz@mleia.com, linux@prisktech.co.nz, sparclinux@vger.kernel.org, khilman@baylibre.com, macro@linux-mips.org, slemieux.tyco@gmail.com, matthias.bgg@gmail.com, jacmet@sunsite.dk, linux-amlogic@lists.infradead.org, andriy.shevchenko@linux.intel.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: linux-serial@vger.kernel.org

On 29.04.19 18:16, Christophe Leroy wrote:

Hi,

> Got the following build  error while compiling for my powerpc board with
> your full series applied. No time to investigate though.

thanks, fixed it. That was the unclean patch where i've forgotten to
add 'rfc' into the title ... turned out that this one needs some
more rework :o

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
