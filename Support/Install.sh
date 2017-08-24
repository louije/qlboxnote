#!/bin/sh

#  Install.sh
#  QLBoxnote
#
#  Created by Louis-Jean Teitelbaum on 24/08/2017.
#  Copyright © 2017 Meidosem. All rights reserved.
#  Taken from https://aleksandrov.ws/2014/02/25/osx-quick-look-plugin-development/

PRODUCT="${PRODUCT_NAME}.qlgenerator"
QL_PATH=~/Library/QuickLook/

rm -rf "$QL_PATH/$PRODUCT"
test -d "$QL_PATH" || mkdir -p "$QL_PATH" && cp -R "$BUILT_PRODUCTS_DIR/$PRODUCT" "$QL_PATH"
qlmanage -r

echo "$PRODUCT installed in $QL_PATH"
