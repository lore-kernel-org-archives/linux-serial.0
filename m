From: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: Re: [EXT] Re: [PATCH 1/6] dt-bindings: arm: fsl: Add the S32V234-EVB
 board
Date: Sat, 3 Aug 2019 08:00:31 +0000
Message-ID: <VI1PR0402MB28635B9758CBF72504191693DFD80@VI1PR0402MB2863.eurprd04.prod.outlook.com>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
 <20190802194702.30249-2-stefan-gabriel.mirea@nxp.com>
 <CAL_JsqL++GZBxczxePni9ysNq06kObB4EzJEi1e4M=PurPZFgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Eddy Petrisor <eddy.petrisor@nxp.com>, "will@kernel.org" <will@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Leo Li <leoyang.li@nxp.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hello Rob,

On 8/3/2019 1:38 AM, Rob Herring wrote:
> On Fri, Aug 2, 2019 at 1:47 PM Stefan-gabriel Mirea
> <stefan-gabriel.mirea@nxp.com> wrote:
>> +      - description: S32V234 Customer Evaluation Board
>
> Most of the entries in this file are for all the boards for an SoC.
>
>> +        items:
>> +          - enum:
>> +              - fsl,s32v234-evb
>
> If that's not going to be the case here, you can use 'const' here.

We also intend to submit patches for the SBC-S32V234[1] board in the
future and I believe that its 'compatible' should share this entry.
Would it therefore be preferable to update the description at this
moment and add a comment, like:

      - description: S32V234 based Boards
        items:
          - enum:
              - fsl,s32v234-evb           # S32V234-EVB2 Customer Evaluation Board
          - const: fsl,s32v234

or just replace the single-value 'enum' with a 'const' for now?

Regards,
Stefan

[1] https://www.nxp.com/design/development-boards/automotive-development-platforms/s32v-mpus-platforms/s32v-vision-and-sensor-fusion-evaluation-board:SBC-S32V234
