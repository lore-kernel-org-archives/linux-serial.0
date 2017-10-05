From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] Arm: dts: stm32: remove extra compatible string for
 uart
Date: Thu, 5 Oct 2017 18:32:03 -0500
Message-ID: <20171005233203.6o4cs3xzvzlcsr2m@rob-hp-laptop>
References: <1506639114-16913-1-git-send-email-vikas.manocha@st.com>
 <1506639114-16913-2-git-send-email-vikas.manocha@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1506639114-16913-2-git-send-email-vikas.manocha@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vikas Manocha <vikas.manocha@st.com>
Cc: linux-kernel@vger.kernel.org, alexandre.torgue@st.com, patrice.chotard@st.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 28, 2017 at 03:51:24PM -0700, Vikas Manocha wrote:
> This patch removes the extra compatibility string "st,stm32-usart" to
> avoid confusion, save some time & space.

I'm confused why you don't need it anymore. I thought the h/w blocks 
were configured differently.

> 
> Signed-off-by: Vikas Manocha <vikas.manocha@st.com>
> Reviewed-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>  Documentation/devicetree/bindings/dma/stm32-dma.txt         |  2 +-
>  Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 10 +++-------
>  2 files changed, 4 insertions(+), 8 deletions(-)

In any case,

Acked-by: Rob Herring <robh@kernel.org>
