From: Bich HEMON <bich.hemon@st.com>
Subject: Re: [PATCH 0/2] Update interrupt names
Date: Tue, 6 Mar 2018 09:58:38 +0000
Message-ID: <d855b529-be9b-13d9-8834-c2d0b7a16884@st.com>
References: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
Content-Language: en-US
Content-ID: <0AA9BE539F3A4A4AAAC39B354D85FF2F@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi all,

On 02/28/2018 11:51 AM, Bich HEMON wrote:
> This patchset updates existing stm32 usart driver by updating interrupt
> initialization by name.
> 
> Bich Hemon (2):
>    dt-bindings: serial: stm32: add wakeup option using note
>    serial: stm32: update interrupt initialization
> 
>   Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 4 ++++
>   drivers/tty/serial/stm32-usart.c                            | 4 ++--
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 

Please note that this patch set is abandoned. As Rob pointed that out, 
the interrupt indices are fixed, so there is no need to keep these patches.

Best regards,

Bich
