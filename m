From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4/9] serial: stm32: fix pio transmit timeout
Date: Sun, 30 Jul 2017 07:32:56 -0700
Message-ID: <20170730143256.GA30584@kroah.com>
References: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
 <1499958494-19354-5-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1499958494-19354-5-git-send-email-bich.hemon@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bich HEMON <bich.hemon@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Jul 13, 2017 at 03:08:28PM +0000, Bich HEMON wrote:
> From: Gerald Baeza <gerald.baeza@st.com>
> 
> 100µs was too short for low speed transmission
> (9600bps)
> 
> Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> ---
>  drivers/tty/serial/stm32-usart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This patch did not apply :(
