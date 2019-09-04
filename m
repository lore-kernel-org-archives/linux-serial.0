From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: serial: Convert riscv,sifive-serial to json-schema
Date: Wed, 4 Sep 2019 11:29:49 +0100
Message-ID: <CAL_JsqK8UpZ1Nn4CbcKgW7xgezy20JtdJ6=niyJK_aV3as6Jxg@mail.gmail.com>
References: <1567592383-8920-1-git-send-email-pragnesh.patel@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567592383-8920-1-git-send-email-pragnesh.patel@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pragnesh Patel <pragnesh.patel@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Albert Ou <aou@eecs.berkeley.edu>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Sep 4, 2019 at 11:20 AM Pragnesh Patel
<pragnesh.patel@sifive.com> wrote:
>
> Convert the riscv,sifive-serial binding to DT schema using json-schema.
>
> Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
> ---
>
> Changes in v2:
> - Replace enum with items in compatible property
>
>  .../devicetree/bindings/serial/sifive-serial.txt   | 33 ------------
>  .../devicetree/bindings/serial/sifive-serial.yaml  | 62 ++++++++++++++++++++++
>  2 files changed, 62 insertions(+), 33 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
