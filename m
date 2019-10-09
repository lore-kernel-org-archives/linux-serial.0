From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Subject: Re: [PATCH v8 2/5] MIPS: PCI: use information from 1-wire PROM for
 IOC3 detection
Date: Wed, 9 Oct 2019 14:25:22 +0200
Message-ID: <ea44d4a2-3011-fba8-4d6a-7b63c77ba00a@amsat.org>
References: <20191009101713.12238-1-tbogendoerfer@suse.de>
 <20191009101713.12238-3-tbogendoerfer@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191009101713.12238-3-tbogendoerfer@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>, Jakub Kicinski <jakub.kicinski@netronome.com>, Jonathan Corbet <corbet@lwn.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 10/9/19 12:17 PM, Thomas Bogendoerfer wrote:
> IOC3 chips in SGI system are conntected to a bridge ASIC, which has

Typo: "connected".

> a 1-wire prom attached with part number information. This changeset
> uses this information to create PCI subsystem information, which
> the MFD driver uses for further platform device setup.
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>   arch/mips/include/asm/pci/bridge.h |   1 +
>   arch/mips/include/asm/sn/ioc3.h    |   9 +++
>   arch/mips/pci/pci-xtalk-bridge.c   | 135 ++++++++++++++++++++++++++++++++++++-
>   arch/mips/sgi-ip27/ip27-xtalk.c    |  38 +++++++++--
>   4 files changed, 175 insertions(+), 8 deletions(-)
