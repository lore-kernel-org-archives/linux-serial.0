From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: stm32: fix initialization of RS485 mode
Date: Thu, 15 Mar 2018 16:41:15 +0100
Message-ID: <CAK8P3a3sn4Z70VHXQmLV344uCX-a1=H=6m-yTy1HxFQMQRiHrg@mail.gmail.com>
References: <1521103480-6940-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521103480-6940-1-git-send-email-bich.hemon@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bich HEMON <bich.hemon@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 15, 2018 at 9:44 AM, Bich HEMON <bich.hemon@st.com> wrote:
> Configure RS485 mode during port initialization.
>
> Fixes: 1bcda09d291081a7732fcaa9d1745312404a4e36 ("serial: stm32: add
> support for RS485 hardware control mode")
>
> Signed-off-by: Bich Hemon <bich.hemon@st.com>

I noticed the unused-function warning from the original patch, and the
patch also fixes that (besides looking like it does the right thing).

Acked-by: Arnd Bergmann <arnd@arndb.de>
