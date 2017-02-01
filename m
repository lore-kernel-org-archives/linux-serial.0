From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 06/10] dt-bindings: serial: Update 'uart-has-rtscts'
 description
Date: Wed, 1 Feb 2017 09:41:21 -0600
Message-ID: <20170201154121.fc6vccvup5nztvnf@rob-hp-laptop>
References: <20170127172804.23881-1-lee.jones@linaro.org>
 <20170127172804.23881-7-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170127172804.23881-7-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, dt@kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, patrice.chotard@st.com
List-Id: linux-serial@vger.kernel.org

On Fri, Jan 27, 2017 at 05:28:00PM +0000, Lee Jones wrote:
> 'uart-has-rtscts' property and 'rts-gpios|cts-gpios' are normally
> mutually exclusive, however it is possible for some drivers to have
> a dynamic approach, meaning that both properties can be relevant.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  Documentation/devicetree/bindings/serial/serial.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
